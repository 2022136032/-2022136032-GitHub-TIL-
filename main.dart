<!-- 
  이 파일은 이전 React 파일이 렌더링되지 않는 문제를 해결하기 위해 
  순수 HTML, Tailwind CSS, 그리고 JavaScript로 재작성되었습니다. 
  복잡한 React 라이프사이클을 우회하여 미리보기가 확실하게 표시되도록 합니다.
-->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>당근마켓 클론 (HTML)</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* 기본 스타일: 배경색과 글꼴 */
        body {
            background-color: #111111;
            font-family: 'Inter', sans-serif;
        }
        /* 당근마켓 다크 모드 테마 변수 */
        :root {
            --primary-color: #FE7E36;
            --background-color: #212123;
            --text-color: white;
            --border-color: #333333;
        }
        /* 모바일 프레임 강제 크기 지정 */
        #mobile-frame {
            width: 100%;
            max-width: 400px;
            height: 750px; /* 높이를 명시적으로 고정 */
            background-color: var(--background-color);
            border: 8px solid var(--border-color);
        }
        /* 콘텐츠 영역 설정 */
        #content-area {
            height: calc(100% - 16px - 64px - 64px); /* 전체 높이 - 상태바 - 앱바 - 하단바 */
            overflow-y: auto;
        }
        /* 커스텀 아이콘 스타일 (Lucide 아이콘 대신 SVG 직접 사용) */
        .icon {
            fill: none;
            stroke: currentColor;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
        }
    </style>
</head>
<body class="flex justify-center items-start min-h-screen p-4">

    <!-- Mobile Frame Simulation -->
    <div id="mobile-frame" class="rounded-3xl shadow-2xl flex flex-col relative overflow-hidden">
        
        <!-- Status Bar Mock -->
        <div class="h-4 w-full" style="background-color: var(--background-color);"></div>
        
        <!-- App Bar -->
        <div id="app-bar" class="flex items-center justify-between p-4 border-b sticky top-0 z-10" style="background-color: var(--background-color); border-color: var(--border-color);">
            <div class="flex items-center text-lg font-bold" style="color: var(--text-color);">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" class="icon mr-2" style="color: var(--primary-color);"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0z"/><circle cx="12" cy="10" r="3"/></svg>
                <span class="cursor-pointer">역삼동</span>
            </div>
            <div class="flex space-x-4" style="color: var(--text-color);">
                <svg onclick="showMessage('검색 기능 시뮬레이션')" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" class="icon cursor-pointer"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
                <svg onclick="showMessage('알림 기능 시뮬레이션')" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" class="icon cursor-pointer"><path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9"/><path d="M10.375 22a2 2 0 0 0 3.25 0"/></svg>
            </div>
        </div>

        <!-- Content Area -->
        <div id="content-area" class="flex-grow">
            <!-- Content will be injected here by JavaScript -->
        </div>

        <!-- Floating Action Button (Write Page Route Simulation) -->
        <div 
            id="fab"
            class="absolute bottom-20 right-4 p-4 rounded-full shadow-lg z-30 cursor-pointer transition duration-300 hover:opacity-80" 
            style="background-color: var(--primary-color);"
            onclick="showMessage('상품 등록 페이지로 이동 시뮬레이션입니다.')"
        >
            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" class="icon" style="color: var(--text-color);"><path d="M12 5v14"/><path d="M5 12h14"/></svg>
        </div>
        
        <!-- Bottom Navigation -->
        <div id="bottom-nav" class="flex justify-around items-center h-16 border-t absolute bottom-0 w-full z-10" style="background-color: var(--background-color); border-color: var(--border-color);">
            <!-- Nav Items will be generated here -->
        </div>
    </div>

    <!-- Floating Message Component (Modal for Alerts) -->
    <div id="floating-message" class="hidden fixed inset-0 bg-black bg-opacity-50 items-center justify-center z-50">
        <div class="bg-white p-6 rounded-lg shadow-2xl w-11/12 max-w-sm flex flex-col items-center">
            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-red-500 mb-3"><circle cx="12" cy="12" r="10"/><path d="m15 9-6 6"/><path d="m9 9 6 6"/></svg>
            <p id="message-text" class="text-gray-800 text-center font-semibold mb-4"></p>
            <button 
                onclick="closeMessage()"
                class="bg-red-500 text-white font-bold py-2 px-4 rounded transition hover:bg-red-600"
            >
                닫기
            </button>
        </div>
    </div>

    <script>
        // --- Theme & Mock Data Constants ---
        const PRIMARY_COLOR = '#FE7E36'; 
        const TEXT_COLOR = 'white';
        const BORDER_COLOR = '#333333';
        const MOCK_UID = 'user-uid-1234567890';

        const mockProducts = [
            { id: 1, name: '심박수 추적 스마트워치 X1', price: '150,000원', location: '역삼동', likes: 12, chat: 3, image: 'https://placehold.co/100x100/FE7E36/FFFFFF?text=Watch' },
            { id: 2, name: '디자인 전공 도서 (세트)', price: '25,000원', location: '선릉역', likes: 5, chat: 1, image: 'https://placehold.co/100x100/808080/FFFFFF?text=Book' },
            { id: 3, name: '새제품 텐트/캠핑용품', price: '200,000원', location: '강남구', likes: 25, chat: 7, image: 'https://placehold.co/100x100/40C057/FFFFFF?text=Tent' },
        ];

        let activeTab = 'Home';

        // --- Utility Functions ---
        function showMessage(msg) {
            document.getElementById('message-text').textContent = msg;
            document.getElementById('floating-message').classList.remove('hidden');
            document.getElementById('floating-message').classList.add('flex');
        }

        function closeMessage() {
            document.getElementById('floating-message').classList.add('hidden');
            document.getElementById('floating-message').classList.remove('flex');
        }

        // --- Component Rendering Functions ---

        function getIconSVG(name, size = 24, color = 'currentColor') {
            const icons = {
                Home: `<path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/>`,
                MapPin: `<path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0z"/><circle cx="12" cy="10" r="3"/>`,
                MessageSquare: `<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>`,
                User: `<path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>`,
                Heart: `<path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.51 4.04 3 5.5l7 7Z"/>`
            };
            const path = icons[name] || '';
            return `<svg xmlns="http://www.w3.org/2000/svg" width="${size}" height="${size}" viewBox="0 0 24 24" class="icon" style="color: ${color};">${path}</svg>`;
        }

        function createProductCard(product) {
            const chatIcon = product.chat > 0 ? `
                <div class="flex items-center">
                    ${getIconSVG('MessageSquare', 14, 'rgba(255, 255, 255, 0.6)')}
                    <span class="ml-1">${product.chat}</span>
                </div>` : '';
            
            const likeIcon = product.likes > 0 ? `
                <div class="flex items-center">
                    ${getIconSVG('Heart', 14, 'rgba(255, 255, 255, 0.6)')}
                    <span class="ml-1">${product.likes}</span>
                </div>` : '';

            return `
                <div class="flex p-4 border-b transition duration-150 hover:bg-gray-800 cursor-pointer" style="border-color: var(--border-color);">
                    <div class="w-24 h-24 rounded-lg overflow-hidden flex-shrink-0 mr-4">
                        <img src="${product.image}" alt="${product.name}" class="object-cover w-full h-full" />
                    </div>
                    
                    <div class="flex flex-col justify-between flex-grow">
                        <div>
                            <h3 class="text-base font-medium truncate" style="color: var(--text-color);">${product.name}</h3>
                            <p class="text-xs mt-1" style="color: rgba(255, 255, 255, 0.6);">${product.location}</p>
                            <p class="text-base font-bold mt-1" style="color: var(--text-color);">${product.price}</p>
                        </div>
                        
                        <div class="flex space-x-3 text-xs justify-end items-center" style="color: rgba(255, 255, 255, 0.6);">
                            ${chatIcon}
                            ${likeIcon}
                        </div>
                    </div>
                </div>
            `;
        }

        function renderTabContent() {
            const contentArea = document.getElementById('content-area');
            let contentHTML = '';

            switch (activeTab) {
                case 'Home':
                    contentHTML = `
                        <div class="pb-16">
                            ${mockProducts.map(createProductCard).join('')}
                            <div class="p-8 text-center" style="color: rgba(255, 255, 255, 0.4);">
                                <p>User UID: ${MOCK_UID}</p>
                                <p class="mt-2 text-xs">당근마켓 클론 앱의 메인 화면입니다.</p>
                            </div>
                        </div>
                    `;
                    break;
                case 'Neighborhood':
                    contentHTML = `
                        <div class="p-8 text-center pb-16" style="color: var(--text-color);">
                            ${getIconSVG('MapPin', 48, PRIMARY_COLOR)}
                            <p class="text-xl font-semibold mt-8">동네생활</p>
                            <p class="text-sm mt-2" style="color: rgba(255, 255, 255, 0.6);">동네 사람들과 정보와 이야기를 나누는 공간입니다.</p>
                        </div>
                    `;
                    break;
                case 'Chat':
                    contentHTML = `
                        <div class="p-8 text-center pb-16" style="color: var(--text-color);">
                            ${getIconSVG('MessageSquare', 48, PRIMARY_COLOR)}
                            <p class="text-xl font-semibold mt-8">채팅 목록</p>
                            <p class="text-sm mt-2" style="color: rgba(255, 255, 255, 0.6);">실시간 채팅 기능을 구현할 예정입니다.</p>
                        </div>
                    `;
                    break;
                case 'MyKarrot':
                    contentHTML = `
                        <div class="p-8 text-center pb-16" style="color: var(--text-color);">
                            ${getIconSVG('User', 48, PRIMARY_COLOR)}
                            <p class="text-xl font-semibold mt-8">나의 당근</p>
                            <p class="text-sm mt-2" style="color: rgba(255, 255, 255, 0.6);">로그인 사용자 정보를 관리합니다.</p>
                        </div>
                    `;
                    break;
            }
            contentArea.innerHTML = contentHTML;
        }

        function renderBottomNav() {
            const bottomNav = document.getElementById('bottom-nav');
            const tabs = [
                { name: 'Home', icon: 'Home', label: '홈' },
                { name: 'Neighborhood', icon: 'MapPin', label: '동네생활' },
                { name: 'Chat', icon: 'MessageSquare', label: '채팅' },
                { name: 'MyKarrot', icon: 'User', label: '나의 당근' },
            ];

            bottomNav.innerHTML = tabs.map(tab => {
                const isActive = activeTab === tab.name;
                const color = isActive ? PRIMARY_COLOR : 'rgba(255, 255, 255, 0.5)';
                const iconSVG = getIconSVG(tab.icon, 24, color);

                return `
                    <div 
                        class="flex flex-col items-center cursor-pointer transition duration-150 ease-in-out p-1"
                        onclick="setActiveTabAndRender('${tab.name}')"
                    >
                        ${iconSVG}
                        <span class="text-xs font-medium mt-0.5" style="color: ${color};">${tab.label}</span>
                    </div>
                `;
            }).join('');
        }

        // --- Main Control Function ---
        window.setActiveTabAndRender = function(tabName) {
            activeTab = tabName;
            renderTabContent();
            renderBottomNav();
        }

        // Initial Load
        window.onload = function() {
            setActiveTabAndRender(activeTab);
        }
    </script>
</body>
</html>
