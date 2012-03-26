Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Mar 2012 09:45:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] drivers/s390/block/dasd_eckd.c: add missing
 dasd_sfree_request
Message-ID: <20120326094507.5521a15c@de.ibm.com>
In-Reply-To: <1332700078-19444-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1332700078-19444-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 25 Mar 2012 20:27:58 +0200
Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Extend some error paths to call dasd_sfree_request as done earlier in the
> function.  The error-handling code is also moved to the end of the function.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Good catch, I will add the patch to the s390 tree. Thanks Julia.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
