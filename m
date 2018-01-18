From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/6] s390: add options to change branch prediction
 behaviour for the kernel
Date: Thu, 18 Jan 2018 10:52:23 +0100
Message-ID: <20180118105223.595f6c74.cohuck@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
        <1516182519-10623-4-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-4-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018 10:48:36 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Add the PPA instruction to the system entry and exit path to switch
> the kernel to a different branch prediction behaviour. The instructions
> are added via CPU alternatives and can be disabled with the "nospec"
> or the "nobp=0" kernel parameter. If the default behaviour selected
> with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=1" parameter can be
> used to enable the changed kernel branch prediction.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/Kconfig                 | 17 +++++++++++++
>  arch/s390/include/asm/processor.h |  1 +
>  arch/s390/kernel/alternative.c    | 23 ++++++++++++++++++
>  arch/s390/kernel/early.c          |  2 ++
>  arch/s390/kernel/entry.S          | 50 ++++++++++++++++++++++++++++++++++++++-
>  arch/s390/kernel/ipl.c            |  1 +
>  arch/s390/kernel/smp.c            |  2 ++
>  7 files changed, 95 insertions(+), 1 deletion(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

[This looks sane; but as I don't have insight into the details of the
new instructions, I don't feel confident enough to give a R-b]
