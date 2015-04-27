From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 06/17] target-s390x: Introduce S390 CPU
 facilities
Date: Mon, 27 Apr 2015 10:11:37 +0200
Message-ID: <553DEF39.7070800@de.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com> <1428933396-37887-7-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-7-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 13.04.2015 um 15:56 schrieb Michael Mueller:
[...]
> +    FAC_TRANSACTIONAL_EXE               = 73,
> +    /*
> +     * The store-hypervisor-information facility #74 is
> +     * z/VM related and when added to be handled by QEMU
> +     * when hosted on LPAR. (see: SC24-6179-05 page 953)
> +     */

I find this sentence hard to read.


> +    FAC_ACCESS_EXCEPTION_FS_INDICATION  = 75,
[...]
