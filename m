From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [patch 7/8] zfcp: Automatically attach remote ports
Date: Tue, 10 Jun 2008 21:36:45 +0200
Message-ID: <20080610193645.GA25065@wavehammer.waldi.eu.org>
References: <20080610162053.144590000@de.ibm.com> <20080610162518.530294000@de.ibm.com> <20080610193339.GA24771@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080610193339.GA24771@wavehammer.waldi.eu.org>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Christof Schmitt <christof.schmitt@de.ibm.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Swen Schillig <swen@vn>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 10, 2008 at 09:33:39PM +0200, Bastian Blank wrote:
> On Tue, Jun 10, 2008 at 06:21:00PM +0200, Christof Schmitt wrote:
> > Automatically attach the remote ports in zfcp when the adapter is set
> > online.
> What do you mean with "remote ports"?

Ah, the part with the wwpn. Are you sure that this does not break on
z900? I'm not sure about ports, but it restricts each lun to exactly one
guest.

Bastian

-- 
To live is always desirable.
		-- Eleen the Capellan, "Friday's Child", stardate 3498.9
