From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 3 Jul 2018 13:52:05 +0200
Message-ID: <20180703135205.2ebb107f.cohuck@redhat.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
        <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
        <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
        <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 3 Jul 2018 11:22:10 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 07/03/2018 09:46 AM, Harald Freudenberger wrote:
> > On 02.07.2018 18:28, Halil Pasic wrote:  
> >>
> >>
> >> On 06/29/2018 11:11 PM, Tony Krowiak wrote:  
> >>> This patch provides documentation describing the AP architecture and
> >>> design concepts behind the virtualization of AP devices. It also
> >>> includes an example of how to configure AP devices for exclusive
> >>> use of KVM guests.
> >>>
> >>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >>> ---  
> >> [..]  
> >>> +
> >>> +Reserve APQNs for exclusive use of KVM guests
> >>> +---------------------------------------------
> >>> +The following block diagram illustrates the mechanism by which APQNs are
> >>> +reserved:
> >>> +
> >>> +                              +------------------+
> >>> +                 remove       |                  |   unbind
> >>> +         +------------------->+ cex4queue driver +<-----------+
> >>> +         |                    |                  |            |
> >>> +         |                    +------------------+            |
> >>> +         |                                                    |
> >>> +         |                                                    |
> >>> +         |                                                    |
> >>> ++--------+---------+ register +------------------+      +-----+------+
> >>> +|                  +<---------+                  | bind |            |
> >>> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
> >>> +|                  +--------->+                  |      |            |
> >>> ++------------------+  probe   +---+--------+-----+      +------------+
> >>> +                                  |        |
> >>> +                           create |        | store APQN
> >>> +                                  |        |
> >>> +                                  v        v
> >>> +                              +---+--------+-----+
> >>> +                              |                  |
> >>> +                              |  matrix device   |
> >>> +                              |                  |
> >>> +                              +------------------+
> >>> +
> >>> +The process for reserving an AP queue for use by a KVM guest is:
> >>> +
> >>> +* The vfio-ap driver during its initialization will perform the following:
> >>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
> >>> +  * Create the 'matrix' device in the 'vfio_ap' root
> >>> +  * Register the matrix device with the device core
> >>> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
> >>> +  newer) and to provide the vfio_ap driver's probe and remove callback
> >>> +  interfaces. The reason why older devices are not supported is because there
> >>> +  are no systems available on which to test.
> >>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
> >>> +  in the ap_bus calling the the device driver's remove interface which
> >>> +  unbinds the cc.qqqq queue device from the driver.  
> >>
> >> What if the queue cc.qqqq is already in use? AFAIU unbind is almost as radical as
> >> pulling a cable. What is the proper procedure an admin should follow before doing
> >> the unbind?  
> > What do you mean on this level with 'in use'? A unbind destroys the association
> > between device and driver. There is no awareness of 'in use' or 'not in use' on this
> > level. This is a hard unbind.  
> >>  
> 
> 
> Let me try to invoke the DASD analogy. If one for some reason wants to detach
> a DASD the procedure to follow seems to be (see
> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html)
> the following:
> 1) Unmount.
> 2) Offline possibly using safe_offline.
> 3) Detach.
> 
> Detaching a disk that is currently doing I/O asks for trouble, so the admin is encouraged
> to make sure there is no pending I/O.

I don't think we can use dasd (block devices) as a good analogy for
every kind of device (for starters, consider network devices).

> In case of AP you can interpret my 'in use' as the queue is not empty. In my understanding
> unbind is supposed to be hard (I used the word radical). That's why I compared it to pulling
> a cable. So that's why I ask is there stuff the admin is supposed to do before doing the
> unbind.

Are you asking for a kind of 'quiescing' operation? I would hope that
the crypto drivers already can deal with that via flushing the queue,
not allowing new requests, or whatever. This is not the block device
case.

Anyway, this is an administrative issue. If you don't have a clear
concept which devices are for host usage and which for guest usage, you
already have problems.

Speaking of administrative issues, is there libvirt support for vfio-ap
under development? It would be helpful to validate the approach.
