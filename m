From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Wed, 16 May 2018 10:21:55 +0200
Message-ID: <9ee148c9-1d3b-860a-32d8-8a1584628233@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/05/2018 17:11, Tony Krowiak wrote:
> Introduces a new AP device driver. This device driver
> is built on the VFIO mediated device framework. The framework
> provides sysfs interfaces that facilitate passthrough
> access by guests to devices installed on the linux host.
...snip...
> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
> +{

You should take care of the ap devices when they are added or removed
from the matrix.
I suggest you add a remove callback to avoid unbinding a queue while
it is assigned to a guest.

> +	return 0;
> +}
> +
> +static void vfio_ap_matrix_dev_release(struct device *dev)
> +{
> +	struct ap_matrix *ap_matrix = dev_get_drvdata(dev);
> +
> +	kfree(ap_matrix);
> +}
...snip...

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
