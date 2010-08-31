Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Aug 2010 14:49:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 7/7] wire up sys_time_change_notify() on s390
Message-ID: <20100831124928.GB2166@osiris.boeblingen.de.ibm.com>
References: <1283255151-6364-1-git-send-email-virtuoso@slind.org>
 <1283255151-6364-7-git-send-email-virtuoso@slind.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1283255151-6364-7-git-send-email-virtuoso@slind.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexander Shishkin <virtuoso@slind.org>
Cc: lkml@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 31, 2010 at 02:45:51PM +0300, Alexander Shishkin wrote:
> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
> index a8fee1b..b242383 100644
> --- a/arch/s390/kernel/syscalls.S
> +++ b/arch/s390/kernel/syscalls.S
> @@ -343,3 +343,4 @@ SYSCALL(sys_perf_event_open,sys_perf_event_open,sys_perf_event_open_wrapper)
>  SYSCALL(sys_fanotify_init,sys_fanotify_init,sys_fanotify_init_wrapper)
>  SYSCALL(sys_fanotify_mark,sys_fanotify_mark,sys_fanotify_mark_wrapper)
>  SYSCALL(sys_prlimit64,sys_prlimit64,sys_prlimit64_wrapper)
> +SYSCALL(sys_time_change_notify,sys_time_change_notify,sys_time_change_notify_wrapper) /* 335 */
> \ No newline at end of file

Please add the missing newline. Thanks.
