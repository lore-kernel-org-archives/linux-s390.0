Return-Path: <linux-kernel-owner+w=401wt.eu-S1755751AbYHRR5Z@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] S390 : Set SLI on PSF/PRSSD on Dasd ECKD initialisation
Date: Mon, 18 Aug 2008 19:56:49 +0200
References: <1218726426.25578.0.camel@localhost> <48A58F9A.8070301@linux.vnet.ibm.com> <48A9AC82.5060505@vmfacility.fr>
In-Reply-To: <48A9AC82.5060505@vmfacility.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808181956.50108.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Weinhuber <wein@linux.vnet.ibm.com>
Cc: Ivan Warren <ivan@vmfacility.fr>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday 18 August 2008, Ivan Warren wrote:
> > The following patch works fine on current hardware. Can you please
> > verify that it indeed fixes your problem as well?
> >
> > Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>

[...]

> Sorry for taking such a long time to respond..
>
> I like the patch. You are right, it's probably better to set the right
> length then hide it ! My initial rationale to SLI instead of altering
> the length was that I couldn't know if there was any obscure reason for
> setting the length to 16 instead of 12 (I thought it could have been
> related to DS8K PAV/HyperPAV support)..
>
> I also tried it on my rig, and it does seem to take care of the problem
>
>     Reviewed-by: Ivan Warren <ivan@vmfacility.fr>
>     Tested-by: Ivan Warren <ivan@vmfacility.fr>

Could this patch please also be pushed for the next stable update (2.6.26 
and maybe even 2.6.25) by adding:
      CC: stable <stable@kernel.org>
?

TIA,
FJP
