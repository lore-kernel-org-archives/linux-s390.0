Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190108032657.8331-1-deepa.kernel@gmail.com> <20190108032657.8331-2-deepa.kernel@gmail.com>
In-Reply-To: <20190108032657.8331-2-deepa.kernel@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 7 Jan 2019 20:47:05 -0800
Message-ID: <CAMo8Bf+BA-Z78E-VQ3QNPrQVFD0kJrhJdmUZw=ZchfP6iYg_dA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] arch: Use asm-generic/socket.h when possible
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Chris Zankel <chris@zankel.net>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 7, 2019 at 7:28 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Many architectures maintain an arch specific copy of the
> file even though there are no differences with the asm-generic
> one. Allow these architectures to use the generic one instead.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: chris@zankel.net
> Cc: fenghua.yu@intel.com
> Cc: tglx@linutronix.de
> Cc: schwidefsky@de.ibm.com
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/ia64/include/uapi/asm/Kbuild     |   1 +
>  arch/ia64/include/uapi/asm/socket.h   | 120 -------------------------
>  arch/s390/include/uapi/asm/Kbuild     |   1 +
>  arch/s390/include/uapi/asm/socket.h   | 117 ------------------------
>  arch/x86/include/uapi/asm/Kbuild      |   1 +
>  arch/x86/include/uapi/asm/socket.h    |   1 -
>  arch/xtensa/include/asm/Kbuild        |   1 +
>  arch/xtensa/include/uapi/asm/Kbuild   |   1 +
>  arch/xtensa/include/uapi/asm/socket.h | 122 --------------------------
>  9 files changed, 5 insertions(+), 360 deletions(-)
>  delete mode 100644 arch/ia64/include/uapi/asm/socket.h
>  delete mode 100644 arch/s390/include/uapi/asm/socket.h
>  delete mode 100644 arch/x86/include/uapi/asm/socket.h
>  delete mode 100644 arch/xtensa/include/uapi/asm/socket.h

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
