Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Sep 2016 09:04:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/lcs: remove trailing space at end of dev_err
 message
In-Reply-To: <20160927195701.15624-1-colin.king@canonical.com>
References: <20160927195701.15624-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160928090434.640c098b@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Sep 2016 12:57:01 -0700
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a trailing white space at the end of a dev_err
> message that does nothing useful - remove it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
