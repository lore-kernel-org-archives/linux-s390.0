From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/5] prctl: add PR_ISOLATE_BP process control
Date: Tue, 23 Jan 2018 18:07:19 +0100
Message-ID: <20180123170719.GA4154@isilmar-4.linta.de>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 23, 2018 at 02:07:01PM +0100, Martin Schwidefsky wrote:
> Add the PR_ISOLATE_BP operation to prctl. The effect of the process
> control is to make all branch prediction entries created by the execution
> of the user space code of this task not applicable to kernel code or the
> code of any other task.

What is the rationale for requiring a per-process *opt-in* for this added
protection?

For KPTI on x86, the exact opposite approach is being discussed (see, e.g.
http://lkml.kernel.org/r/1515612500-14505-1-git-send-email-w@1wt.eu ): By
default, play it safe, with KPTI enabled. But for "trusted" processes, one
may opt out using prctrl.

Thanks,
	Dominik
