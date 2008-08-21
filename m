Return-Path: <linux-kernel-owner+w=401wt.eu-S1757436AbYHUQce@vger.kernel.org>
Date: Thu, 21 Aug 2008 18:32:16 +0200
From: Stefan Weinhuber <wein@linux.vnet.ibm.com>
Subject: Re: [PATCH] S390 : Set SLI on PSF/PRSSD on Dasd ECKD initialisation
Message-ID: <20080821163215.GA4444@BL3VMDRG>
References: <1218726426.25578.0.camel@localhost> <48A58F9A.8070301@linux.vnet.ibm.com> <48A9AC82.5060505@vmfacility.fr> <200808181956.50108.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200808181956.50108.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: Ivan Warren <ivan@vmfacility.fr>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 18, 2008 at 07:56:49PM +0200, Frans Pop wrote:
> On Monday 18 August 2008, Ivan Warren wrote:
> > > The following patch works fine on current hardware. Can you please
> > > verify that it indeed fixes your problem as well?
> > >
> > > Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
> 
> [...]
> 
> > Sorry for taking such a long time to respond..
> >
> > I like the patch. You are right, it's probably better to set the right
> > length then hide it ! My initial rationale to SLI instead of altering
> > the length was that I couldn't know if there was any obscure reason for
> > setting the length to 16 instead of 12 (I thought it could have been
> > related to DS8K PAV/HyperPAV support)..
> >
> > I also tried it on my rig, and it does seem to take care of the problem
> >
> >     Reviewed-by: Ivan Warren <ivan@vmfacility.fr>
> >     Tested-by: Ivan Warren <ivan@vmfacility.fr>
> 
> Could this patch please also be pushed for the next stable update (2.6.26 
> and maybe even 2.6.25) by adding:
>       CC: stable <stable@kernel.org>

Ivan,
  thanks for reporting the problem and reviewing the patch.
  I've submitted the patch to our local repository, so it can
  be picked up by Martin, our maintainer, for further processing.

Frans,
  thanks for your suggestion. I've added a respective CC: stable
  line as well.
