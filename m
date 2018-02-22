From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 12:30:31 +0000
Subject: Re: [PATCH] s390: fix comment for scsw_cmd_is_valid_sctl
Message-Id: <alpine.LFD.2.21.1802221329480.1603@schleppi>
In-Reply-To: <20180222121416.26231-1-cohuck@redhat.com>
References: <20180222121416.26231-1-cohuck@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 22 Feb 2018, Cornelia Huck wrote:
> This function is checking for the suspend control, not the function
> control.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Applied. Thanks!
