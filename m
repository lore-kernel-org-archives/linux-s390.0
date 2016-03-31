Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160331152651.650e334a@mschwide>
References: <20160331145724.13258ddb@mschwide>
	<CA+55aFyEDjfDd_Ni3ZUcf4jkwBYvuLZOdmWP-FnRgchW1hj5OQ@mail.gmail.com>
	<20160331152651.650e334a@mschwide>
Date: Thu, 31 Mar 2016 14:29:09 -0500
Message-ID: <CA+55aFy8DuvwBfg5PcpTZYvXYeA7Vxq+w9XoOMErwQB7nq93wg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 4.6-rc2
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 31, 2016 at 8:26 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> I really would like to see the "s390/dasd: reorder lcu and device lock" go
> into 4.6 as the current solution is really ugly. But I'll remove the patch
> with the new attribute. Would that be acceptable?

That sounds better, yes.

Thanks,

     Linus
