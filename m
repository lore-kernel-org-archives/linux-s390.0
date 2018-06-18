Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 18 Jun 2018 13:26:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: hypfs: use ktime_get_seconds() instead of
 get_seconds()
In-Reply-To: <20180618100534.1857997-1-arnd@arndb.de>
References: <20180618100534.1857997-1-arnd@arndb.de>
MIME-Version: 1.0
Message-Id: <20180618132643.79cbed17@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, y2038@lists.linaro.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 18 Jun 2018 12:05:00 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> time_t and get_seconds() are deprecated because they will overflow on
> 32-bit architectures in the future. This is not a problem on 64-bit s390,
> but we should use proper interfaces anyway.
> 
> Besides moving to the time64_t based interface, the CLOCK_MONOTONIC
> based ktime_get_seconds() is preferred for kernel internal timekeeping
> because it does not behave in unexpected ways during leap second changes
> or settimeofday() calls.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to my set of patches for the next merge window.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
