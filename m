From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/5] s390x: Add I/O adapter registration.
Date: Tue, 18 Mar 2014 17:10:33 +0100
Message-ID: <53286FF9.6050602@redhat.com>
References: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com> <1395079921-29325-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079921-29325-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Il 17/03/2014 19:11, Cornelia Huck ha scritto:
> +static KVMS390FLICState *s390_get_flic(void)
> +{
> +    ObjectProperty *op = object_property_find(qdev_get_machine(),
> +                                              "s390-flic", NULL);
> +
> +    if (op) {
> +        return op->opaque;
> +    } else {
> +        return NULL;
> +    }
> +}

You can use object_resolve_path("/machine/s390-flic", NULL) instead.

Paolo
