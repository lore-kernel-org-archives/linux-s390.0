Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Feb 2012 10:20:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] arch/s390/kernel/crash_dump.c: included
 linux/crash_dump.h twice
Message-ID: <20120217102024.1c838437@de.ibm.com>
In-Reply-To: <1329400541-31849-1-git-send-email-danny.kukawka@bisect.de>
References: <1329400541-31849-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: Danny Kukawka <dkukawka@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 16 Feb 2012 14:55:41 +0100
Danny Kukawka <danny.kukawka@bisect.de> wrote:

> arch/s390/kernel/crash_dump.c included 'linux/crash_dump.h' twice,
> remove the duplicate.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Added to the s390 tree. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
