Return-Path: <linux-kernel-owner+w=401wt.eu-S932900Ab0AGJY1@vger.kernel.org>
Date: Thu, 7 Jan 2010 10:24:18 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] S390: use helpers for rlimits
Message-ID: <20100107102418.356be58c@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1262791479-26594-4-git-send-email-jslaby@suse.cz>
References: <1262791479-26594-1-git-send-email-jslaby@suse.cz>
	<1262791479-26594-4-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed,  6 Jan 2010 16:24:32 +0100
Jiri Slaby <jslaby@suse.cz> wrote:

> Make sure compiler won't do weird things with limits. E.g. fetching
> them twice may return 2 different values after writable limits are
> implemented.
> 
> I.e. either use rlimit helpers added in
> 3e10e716abf3c71bdb5d86b8f507f9e72236c9cd
> or ACCESS_ONCE if not applicable.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> ---

Added to the git390 queue. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
