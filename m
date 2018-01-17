From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/6] s390: improve speculative execution handling
Date: Wed, 17 Jan 2018 13:05:41 +0100
Message-ID: <9a542409-59ef-57f0-3d90-04e88354d1c3@de.ibm.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <20180117130038.4830f89b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117130038.4830f89b.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>



On 01/17/2018 01:00 PM, Cornelia Huck wrote:
> On Wed, 17 Jan 2018 10:48:33 +0100
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
>> This patch series implements multiple mitigations for the speculative
>> execution findings:
>> 1. The definition of the gmb() barrier as currently used by the
>>    distributions, we may have to find a better name for it
>> 2. The architecture code for the nospec interfaces, the macros for
>>    nospec_ptr and nospec_load just use the gmb() barrier
>> 3. The enablement for firmware features to switch between different
>>    branch prediction modes. It comes with a config option
>>    CONFIG_KERNEL_NOBP, two new kernel parameters "nobp=[0|1]" and
>>    "nospec", and a new system call s390_modify_bp.
>>    With CONFIG_KERNEL_NOBP=y the new branch prediction mode is active
>>    for the kernel code by default and can be switched off with "nospec"
>>    or "nobp=0". With CONFIG_KERNEL_NOBP=n the new mode is inactive for
>>    kernel code unless "nobp=1" is specified.
>>    User space code can use the trapdoor system call s390_modify_bp to
>>    set the new TIF_NOBP bit. This switches to the new branch prediction
>>    mode for the lifetime of the task, any children of the task will
>>    inherit this attribute.
>>    The vCPU of a KVM guest will run with the new branch prediction
>>    mode if either the associated qemu task has TIF_NOBP set or if the
>>    KVM kernel code sets TIF_NOBP_GUEST. The later will require a small
>>    update to KVM backend.
> 
> How does this interact with the facility bits? Bit 81 seems to indicate
> function code f (gmb), while bit 82 seems to indicate function codes
> c/d (branch prediction modes). Both seem to be in the range of bits
> transparently passed through for kvm (although this still needs a qemu
> update to the cpu models so the bits are not masked out as unknown.)

Correct.
I will send a qemu patch soon.
