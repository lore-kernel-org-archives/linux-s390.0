From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
Date: Fri, 28 Sep 2018 13:42:13 +0200
Message-ID: <2c045dc8-6b73-6b9d-5d1a-c256ca20685b@de.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
 <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 09/27/2018 09:19 PM, Tony Krowiak wrote:

> The following fixup attempts to clarify the bit ordering confusion,
> hopefully this is acceptable.
> 

looks good to me, I will fold in.

> -----------------------------------8<-----------------------------------
> 
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> Date: Thu, 27 Sep 2018 14:51:12 -0400
> Subject: [FIXUP v10] fixup! s390: doc: detailed specifications for AP
>  virtualization
> 
> Better explains mask bit ordering.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ap.txt | 127 +++++++++++++++++++++++----------
>  1 file changed, 91 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
> index bec67eb7141c..599eb0f75c07 100644
> --- a/Documentation/s390/vfio-ap.txt
> +++ b/Documentation/s390/vfio-ap.txt
> @@ -123,21 +123,24 @@ to identify the adapters, usage domains and control domains assigned to the KVM
>  guest:
> 
>  * The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
> -  to the KVM guest. Each bit in the mask, from most significant to least
> -  significant bit, corresponds to an APID from 0-255. If a bit is set, the
> -  corresponding adapter is valid for use by the KVM guest.
> +  to the KVM guest. Each bit in the mask, from left to right (i.e. from most
> +  significant to least significant bit in big endian order), corresponds to
> +  an APID from 0-255. If a bit is set, the corresponding adapter is valid for
> +  use by the KVM guest.
> 
>  * The AP Queue Mask (AQM) field is a bit mask identifying the AP usage domains
> -  assigned to the KVM guest. Each bit in the mask, from most significant to
> -  least significant bit, corresponds to an AP queue index (APQI) from 0-255. If
> -  a bit is set, the corresponding queue is valid for use by the KVM guest.
> +  assigned to the KVM guest. Each bit in the mask, from left to right (i.e. from
> +  most significant to least significant bit in big endian order), corresponds to
> +  an AP queue index (APQI) from 0-255. If a bit is set, the corresponding queue
> +  is valid for use by the KVM guest.
> 
>  * The AP Domain Mask field is a bit mask that identifies the AP control domains
>    assigned to the KVM guest. The ADM bit mask controls which domains can be
>    changed by an AP command-request message sent to a usage domain from the
> -  guest. Each bit in the mask, from least significant to most significant bit,
> -  corresponds to a domain from 0-255. If a bit is set, the corresponding domain
> -  can be modified by an AP command-request message sent to a usage domain.
> +  guest. Each bit in the mask, from left to right (i.e. from most significant to
> +  least significant bit in big endian order), corresponds to a domain from
> +  0-255. If a bit is set, the corresponding domain can be modified by an AP
> +  command-request message sent to a usage domain.
> 
>  If you recall from the description of an AP Queue, AP instructions include
>  an APQN to identify the AP queue to which an AP command-request message is to be
> @@ -503,23 +506,34 @@ These are the steps:
>     access them. To secure them, there are two sysfs files that specify
>     bitmasks marking a subset of the APQN range as 'usable by the default AP
>     queue device drivers' or 'not usable by the default device drivers' and thus
> -   available for use by the vfio_ap device driver'. The sysfs files containing
> -   the sysfs locations of the masks are:
> +   available for use by the vfio_ap device driver'. The location of the sysfs
> +   files containing the masks are:
> 
>     /sys/bus/ap/apmask
>     /sys/bus/ap/aqmask
> 
>     The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
> -   (APID). Each bit in the mask, from most significant to least significant bit,
> -   corresponds to an APID from 0-255. If a bit is set, the APID is marked as
> -   usable only by the default AP queue device drivers; otherwise, the APID is
> -   usable by the vfio_ap device driver.
> +   (APID). Each bit in the mask, from left to right (i.e., from most significant
> +   to least significant bit in big endian order), corresponds to an APID from
> +   0-255. If a bit is set, the APID is marked as usable only by the default AP
> +   queue device drivers; otherwise, the APID is usable by the vfio_ap
> +   device driver.
> 
>     The 'aqmask' is a 256-bit mask that identifies a set of AP queue indexes
> -   (APQI). Each bit in the mask, from most significant to least significant bit,
> -   corresponds to an APQI from 0-255. If a bit is set, the APQI is marked as
> -   usable only by the default AP queue device drivers; otherwise, the APQI is
> -   usable by the vfio_ap device driver.
> +   (APQI). Each bit in the mask, from left to right (i.e., from most significant
> +   to least significant bit in big endian order), corresponds to an APQI from
> +   0-255. If a bit is set, the APQI is marked as usable only by the default AP
> +   queue device drivers; otherwise, the APQI is usable by the vfio_ap device
> +   driver.
> +
> +   Take, for example, the following mask:
> +
> +      0x7dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +
> +    It indicates:
> +
> +      1, 2, 3, 4, 5, and 7-255 belong to the default drivers' pool, and 0 and 6
> +      belong to the vfio_ap device driver's pool.
> 
>     The APQN of each AP queue device assigned to the linux host is checked by the
>     AP bus against the set of APQNs derived from the cross product of APIDs
> @@ -530,38 +544,79 @@ These are the steps:
>     By default, the two masks are set to reserve all APQNs for use by the default
>     AP queue device drivers. There are two ways the default masks can be changed:
> 
> -   1. The masks can be changed at boot time with the kernel command line
> -      like this:
> +   1. The sysfs mask files can be edited by echoing a string into the
> +      respective sysfs mask file in one of two formats:
> +
> +      * An absolute hex string starting with 0x - like "0x12345678" - sets
> +        the mask. If the given string is shorter than the mask, it is padded
> +        with 0s on the right; for example, specifying a mask value of 0x41 is
> +        the same as specifying:
> +
> + 0x4100000000000000000000000000000000000000000000000000000000000000
> +
> +        Keep in mind that the mask reads from left to right (i.e., most
> +        significant to least significant bit in big endian order), so the mask
> +        above identifies device numbers 1 and 7 (01000001).
> +
> +        If the string is longer than the mask, the operation is terminated with
> +        an error (EINVAL).
> +
> +      * Individual bits in the mask can be switched on and off by specifying
> +        each bit number to be switched in a comma separated list. Each bit
> +        number string must be prepended with a ('+') or minus ('-') to indicate
> +        the corresponding bit is to be switched on ('+') or off ('-'). Some
> +        valid values are:
> +
> +           "+0"    switches bit 0 on
> +           "-13"   switches bit 13 off
> +           "+0x41" switches bit 65 on
> +           "-0xff" switches bit 255 off
> +
> +           The following example:
> +              +0,-6,+0x47,-0xf0
> +
> +              Switches bits 0 and 71 (0x47) on
> +              Switches bits 6 and 240 (0xf0) off
> +
> +        Note that the bits not specified in the list remain as they were before
> +        the operation.
> +
> +   2. The masks can also be changed at boot time via parameters on the kernel
> +      command line like this:
> 
>           ap.apmask=0xffff ap.aqmask=0x40
> 
> -         This would give these two pools:
> +         This would create the following masks:
> 
> -            default drivers pool:    adapter 0-15, domain 1
> -            alternate drivers pool:  adapter 16-255, domains 2-255
> +            apmask:
> + 0xffff000000000000000000000000000000000000000000000000000000000000
> 
> -   2. The sysfs mask files can also be edited by echoing a string into the
> -      respective file in one of two formats:
> +            aqmask:
> + 0x4000000000000000000000000000000000000000000000000000000000000000
> 
> -      * An absolute hex string starting with 0x - like "0x12345678" - sets
> -        the mask. If the given string is shorter than the mask, it is padded
> -        with 0s on the right. If the string is longer than the mask, the
> -        operation is terminated with an error (EINVAL).
> +         Resulting in these two pools:
> 
> -      * A plus ('+') or minus ('-') followed by a numerical value. Valid
> -        examples are "+1", "-13", "+0x41", "-0xff" and even "+0" and "-0". Only
> -        the corresponding bit in the mask is switched on ('+') or off ('-'). The
> -        values may also be specified in a comma-separated list to switch more
> -        than one bit on or off.
> +            default drivers pool:    adapter 0-15, domain 1
> +            alternate drivers pool:  adapter 16-255, domains 0, 2-255
> 
> +   Securing the APQNs for our example:
> +   ----------------------------------
>     To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
>     06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
> -   APQNs must be removed from the masks as follows:
> +   APQNs can either be removed from the default masks:
> 
>        echo -5,-6 > /sys/bus/ap/apmask
> 
>        echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
> 
> +   Or the masks can be set as follows:
> +
> +      echo 0xf9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff \
> +      > apmask
> +
> +      echo 0xf7fffffffffffffffeffffffffffffffffffffffffeffffffffffffffffffffe \
> +      > aqmask
> +
>     This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004,
>     06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device driver. The
>     sysfs directory for the vfio_ap device driver will now contain symbolic links
