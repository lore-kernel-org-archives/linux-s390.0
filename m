From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 08/19] s390/zcrypt: support for assigning adapters to
 matrix mdev
Date: Fri, 17 Nov 2017 10:50:27 +0100
Message-ID: <20171117105027.3c799524.cohuck@redhat.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-9-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20171114142244.272d538d.cohuck@redhat.com>
        <bbd1af6d-eab0-aeff-ca06-d6701e018f4a@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <bbd1af6d-eab0-aeff-ca06-d6701e018f4a@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 16 Nov 2017 18:53:07 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 11/14/2017 08:22 AM, Cornelia Huck wrote:
> > On Fri, 13 Oct 2017 13:38:53 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> +static ssize_t ap_matrix_adapters_assign(struct device *dev,
> >> +					 struct device_attribute *attr,
> >> +					 const char *buf, size_t count)
> >> +{
> >> +	int ret;
> >> +	unsigned int apid;
> >> +	struct mdev_device *mdev = mdev_from_dev(dev);
> >> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >> +
> >> +	ret = ap_matrix_parse_id(buf, &apid);  
> I'm going to replace this with a call to kstrtouint (buf, 0, &apid). This
> will allow the user to enter the adapter ID string using conventional
> semantics - e.g., 71 or  0x47 - and the function will determine if the
> value is valid.

Using an existing interface sounds good.
