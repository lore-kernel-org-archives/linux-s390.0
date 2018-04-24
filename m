From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
Date: Tue, 24 Apr 2018 15:13:17 +0200
Message-ID: <20180424151317.60513959.cohuck@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
        <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
        <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
        <20180417121044.5c8f2182.cohuck@redhat.com>
        <2ac8b862-e2dc-843e-a0b8-906fa32b42f4@linux.vnet.ibm.com>
        <20180417172139.0a2b148b.cohuck@redhat.com>
        <7276785e-2183-3204-ec80-99fba1546364@linux.vnet.ibm.com>
        <20180418094949.0403dcaf.cohuck@redhat.com>
        <470d8af7-b9f6-0ab7-9bfa-351fbeaa079c@linux.vnet.ibm.com>
        <20180423090337.1b8b465a.cohuck@redhat.com>
        <192888a1-afc8-8502-5c6f-dbb16625bda2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <192888a1-afc8-8502-5c6f-dbb16625bda2@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Harald Freudenberger <FREUDE@de.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, berrange@redhat.com, bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com, fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 24 Apr 2018 09:01:12 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 04/23/2018 03:03 AM, Cornelia Huck wrote:
> > On Sun, 22 Apr 2018 10:52:55 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >  
> >>>>>>> (Not providing a crycb if APXA is not available would be loss of
> >>>>>>> functionality, I guess? Deciding not to provide vfio-ap if APXA is not
> >>>>>>> available is a different game, of course.)  
> >>>>>> This would require a change to enabling the CPU model feature for
> >>>>>> AP.  
> >>>>> But would it actually make sense to tie vfio-ap to APXA? This needs to
> >>>>> be answered by folks with access to the architecture :)  
> >>>> I don't see any reason to do that from an architectural perspective.
> >>>> One can access AP devices whether APXA is installed or not, it just limits
> >>>> the range of devices that can be addressed  
> >>> So I guess we should not introduce a tie-in then (unless it radically
> >>> simplifies the code...)  
> >> I'm not clear about what you mean by introducing a tie-in. Can you
> >> clarify that?  
> > Making vfio-ap depend on APXA.  
> 
> I don't think vfio-ap should be dependent upon APXA for the reasons I 
> stated above.
> 
> >  
> 

It seems we are in violent agreement :)
