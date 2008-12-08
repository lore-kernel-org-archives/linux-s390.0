Return-Path: <linux-kernel-owner+w=401wt.eu-S1753128AbYLHJH0@vger.kernel.org>
Subject: Re: [PATCH 1/2] drivers/s390/crypto: Move dereference to after
	IS_ERR test
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.64.0812072314270.7130@ask.diku.dk>
References: <Pine.LNX.4.64.0812072314270.7130@ask.diku.dk>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 10:06:29 +0100
Message-Id: <1228727189.15048.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2008-12-07 at 23:14 +0100, Julia Lawall wrote:
> If reply is ERR_PTR(...), then it should not be dereferenced, so I have
> moved the dereference from the declaration to after the IS_ERR test.

Nice finding again. That semantic match tools is really useful.
Thanks, I'll add the patch to my collection.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
