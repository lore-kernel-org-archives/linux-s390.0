Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Aug 2010 13:53:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 7/7] wire up sys_time_change_notify() on s390
Message-ID: <20100831135314.253d6544@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1283255151-6364-7-git-send-email-virtuoso@slind.org>
References: <1283255151-6364-1-git-send-email-virtuoso@slind.org>
	<1283255151-6364-7-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexander Shishkin <virtuoso@slind.org>
Cc: lkml@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 31 Aug 2010 14:45:51 +0300
Alexander Shishkin <virtuoso@slind.org> wrote:

> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: linux390@de.ibm.com
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Jesper Nilsson <jesper.nilsson@axis.com>
> CC: David Howells <dhowells@redhat.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: linux-s390@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/s390/include/asm/unistd.h    |    3 ++-
>  arch/s390/kernel/compat_wrapper.S |    6 ++++++
>  arch/s390/kernel/syscalls.S       |    1 +
>  3 files changed, 9 insertions(+), 1 deletions(-)

System-call wiring for s390 looks good.
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
