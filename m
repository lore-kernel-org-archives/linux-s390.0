From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Date: Thu, 14 Feb 2019 16:40:44 +0100
Message-ID: <20190214164044.5e67660a.cohuck@redhat.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
        <20190214155441.087d2a68.cohuck@redhat.com>
        <6147f1ce-fd8b-1ec2-30ce-7ac68f3d8e27@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6147f1ce-fd8b-1ec2-30ce-7ac68f3d8e27@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 14 Feb 2019 16:05:35 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 14.02.2019 15:54, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 14:51:01 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:  
> 
> Pierre,
> this is independent from this series and should have been sent separately.
> In the end (when we have the final solution) this will require cc stable.
> >   
> >> Libudev relies on having a subsystem link for non-root devices. To
> >> avoid libudev (and potentially other userspace tools) choking on the
> >> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> >> bus subsytem, and make the matrix device reside within it.  
> > 
> > How does libudev choke on this? It feels wrong to introduce a bus that
> > basically does nothing...  
> 
> I have seen libvirt looping when a matrix device was available before the
> libvirt start.
> Marc Hartmayer debugged this and circumvented this in libvirt:
> https://www.redhat.com/archives/libvir-list/2019-February/msg00837.html
> 
> Still libudev expects a subsystem link in the matrix folder when doing the 
> udev_enumerate_scan_devices call.
> 
> Having a bus is one way of adding a subsystem link.

Ugh, that feels really broken. Adding a bus is probably the easiest way
to get this working, though :/
