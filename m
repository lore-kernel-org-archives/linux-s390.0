Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Sep 2016 09:04:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/dasd: add missing \n to end of dev_err messages
In-Reply-To: <20160927191318.15264-1-colin.king@canonical.com>
References: <20160927191318.15264-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160928090420.2e137f3f@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Sep 2016 12:13:18 -0700
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_err messages are missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/s390/block/dasd_erp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
