From: Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC PATCH v2 10/15] cpu-model/s390: Add cpu class initialization
 routines
Date: Fri, 20 Feb 2015 08:02:42 -0800
Message-ID: <54E75AA2.9070503@twiddle.net>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On 02/17/2015 06:24 AM, Michael Mueller wrote:
> +/**
> + * s390_test_facility - test if given facility bit is set facility list
> + *                      of given cpu class
> + * @class: address of cpu class to test
> + * @nr: bit number to test
> + *
> + * Returns: true in case it is set
> + *          false in case it is not set
> + */
> +bool s390_test_facility(S390CPUClass *cc, unsigned long nr)
> +{
> +    if (cc) {
> +        return test_facility(nr, cc->fac_list) ? true : false;
> +    }
> +    return false;
> +}

Where do you see this being used?


r~
