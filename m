From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 02 Aug 2018 21:10:54 +0000
Subject: Re: [PATCH v7 14/22] s390: vfio-ap: sysfs interface to activate mdev matrix
Message-Id: <e82e3b5f-5953-6678-8372-6c2721e18be5@linux.ibm.com>
In-Reply-To: <20180802132142.28f89de3.cohuck@redhat.com>
References: <20180802132142.28f89de3.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/02/2018 07:21 AM, Cornelia Huck wrote:
> On Tue, 31 Jul 2018 14:19:23 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> lets just drop the printks for the time being. Its the normal way of kernel
>> things to return with -EINVAL and NOT telling why.
> Agreed. Some non-printk logging can still be added at a later time
> should we want that.

Will do.

>
