From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Tue, 21 Aug 2018 17:25:48 +0200
Message-ID: <20180821172548.57a6c758.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820162317.08bd7d23.cohuck@redhat.com>
        <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 20 Aug 2018 13:41:32 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/20/2018 10:23 AM, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:09 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >  
> >> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>
> >> Provides the sysfs interfaces for:
> >>
> >> 1. Assigning AP control domains to the mediated matrix device
> >>
> >> 2. Unassigning AP control domains from a mediated matrix device
> >>
> >> 3. Displaying the control domains assigned to a mediated matrix
> >>     device
> >>
> >> The IDs of the AP control domains assigned to the mediated matrix
> >> device are stored in an AP domain mask (ADM). The bits in the ADM,
> >> from most significant to least significant bit, correspond to
> >> AP domain numbers 0 to 255. On some systems, the maximum allowable
> >> domain number may be less than 255 - depending upon the host's
> >> AP configuration - and assignment may be rejected if the input
> >> domain ID exceeds the limit.  
> > Please remind me of the relationship between control domains and usage
> > domains... IIRC, usage domains allow both requests and configuration,
> > while control domains allow only configuration, and are by convention a
> > superset of usage domains.  
> 
> A usage domain is a domain to which an AP command-request message can be
> submitted for processing. A control domain is a domain that can
> be changed by an AP command request message submitted to a usage domain.
> AP command request messages to configure a domain will contain the domain
> number of the domain to be modified. The AP firmware will check the
> control domain mask (ADM) and will allow the request to proceed only if
> the corresponding bit in the ADM is set.

Thanks to you and Halil for the explanation.

> 
> >
> > Is there a hard requirement somewhere in there, or can the admin
> > cheerfully use different masks for usage domains and control domains
> > without the SIE choking on it?  
> 
> There is no hard requirement that control domains must be a superset of
> the usage domains, it is merely an architectural convention. AFAIK,
> SIE doesn't enforce this and will not break if the convention is not
> enforced externally. Having said that, you should note that the AQM
> and ADM masks configured for the mediated matrix device will be logically
> OR'd together to create the ADM stored in the CRYCB referenced from the
> guest's SIE state description. In other words, we are enforcing the
> convention in our software.

Hm, that's interesting, as Halil argued that we should not enforce it
in the kernel. Might be somewhat surprising as well. If that is really
the way to do it, this needs to be documented clearly.
