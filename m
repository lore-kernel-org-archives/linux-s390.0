Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/dasd: remove 'struct timespec' usage
References: <20171127114715.2731901-1-arnd@arndb.de>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 13:23:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171127114715.2731901-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Message-Id: <75f426fe-cd8a-61ae-435d-c15c4b34922d@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, y2038@lists.linaro.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 27.11.2017 12:46, Arnd Bergmann wrote:
> getnstimeofday() and timespec are deprecated since they can
> overflow on 32-bit architectures. This simply changes to the
> explicitly typed timespec64 version that doesn't have that
> problem.
>
> It would be nice to also convert to monotonic timestamps
> and call ktime_get_ts64() rather than ktime_get_real_ts64(),
> but that would be a user-visible change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch. I just reviewed, tested and applied it.

Regards,
Stefan
