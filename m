From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/15] cpu-model/s390: Add KVM VM
 attribute interface routines
Date: Fri, 20 Feb 2015 19:42:15 +0100
Message-ID: <20150220194215.7afcc73a@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-10-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73DB8.20902@suse.de>
	<20150220161805.3d04097a@bee>
	<54E767E2.4060100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E767E2.4060100@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 17:59:14 +0100
Alexander Graf <agraf@suse.de> wrote:

> But please give a nutshell explanation on what exactly you're patching
> at all here.

Please don't ask in riddles... :-)

S390ProcessorProps are attributes that represent cpu model related properties of the processor. 

typedef struct S390ProcessorProps {
    uint64_t cpuid;
    uint16_t ibc;
    uint8_t  pad[6];
    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
} S390ProcessorProps;

S390MachineProps are attributes that represent cpu model related properties that a specific host
offers.

fac_list_mask are the facilities that are supported by the accelerator code and the hosting
machine in case of KVM it is kvm_s390_fac_list_mask & STFLE, fac_list is STFLE only

typedef struct S390MachineProps {
    uint64_t cpuid;
    uint32_t ibc_range;
    uint8_t  pad[4];
    uint64_t fac_list_mask[S390_ARCH_FAC_LIST_SIZE_UINT64];
    uint64_t fac_list[S390_ARCH_FAC_LIST_SIZE_UINT64];
} S390MachineProps;

The various S390CPUModel classes represent all well defined cpu models (those which have been
implemented as real machines). Not all of these models are executable on a given host. Only the
most current machine implementation is able to run all models. The list of "runnable" cpu models
is calculated by "matching" the S390MachineProps with the S390CPUModel classes and the
qemu_s390_fac_list_mask[] (indicates the facilities that are implemented by QEMU itself.)

The qemu cpu_model is translated to the respective S390CPUModel class and its processor
properties (S390ProcessorProps) are used with the s390_set_proceccor_props() call to communicate
them to the accelerator what specific cpuid,ibc,fac_list shall be used.

Michael
