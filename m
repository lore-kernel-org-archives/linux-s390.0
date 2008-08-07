Return-Path: <linux-kernel-owner+w=401wt.eu-S1755985AbYHGNuV@vger.kernel.org>
Subject: Re: [PATCH] drivers/s390: Use an IS_ERR test rather than a NULL
	test
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200808071542.22880.brunel@diku.dk>
References: <200808071542.22880.brunel@diku.dk>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 15:49:12 +0200
Message-Id: <1218116952.1033.37.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julien Brunel <brunel@diku.dk>
Cc: heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-08-07 at 15:42 +0200, Julien Brunel wrote:
> In case of error, functions dasd_kmalloc_request and idal_buffer_alloc
> return an ERR pointer, but never return the NULL pointer. So after a
> call to one of these functions, a NULL test should be replaced by an
> IS_ERR test.

Good findings, many thanks! I'll add it to git390 for the next please
pull.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
