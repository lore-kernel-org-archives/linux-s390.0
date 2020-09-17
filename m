Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 17 Sep 2020 10:03:35 +0200
From: Simon Horman <simon.horman@netronome.com>
Subject: Re: [oss-drivers] [trivial PATCH] treewide: Convert switch/case
 fallthrough; to break;
Message-ID: <20200917080334.GB5769@netronome.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>, Kees Cook <kees.cook@canonical.com>, Nick Desaulniers <ndesaulniers@google.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, dm-devel@redhat.com, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, intel-wired-lan@lists.osuosl.org, oss-drivers@netronome.com, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org, storagedev@microchip.com, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, dccp@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-sctp@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>

On Wed, Sep 09, 2020 at 01:06:39PM -0700, Joe Perches wrote:
> fallthrough to a separate case/default label break; isn't very readable.
> 
> Convert pseudo-keyword fallthrough; statements to a simple break; when
> the next label is case or default and the only statement in the next
> label block is break;
> 
> Found using:
> 
> $ grep-2.5.4 -rP --include=*.[ch] -n "fallthrough;(\s*(case\s+\w+|default)\s*:\s*){1,7}break;" *
> 
> Miscellanea:
> 
> o Move or coalesce a couple label blocks above a default: block.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

...

> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> index 252fe06f58aa..1d5b87079104 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> @@ -345,7 +345,7 @@ static int matching_bar(struct nfp_bar *bar, u32 tgt, u32 act, u32 tok,
>  		baract = NFP_CPP_ACTION_RW;
>  		if (act == 0)
>  			act = NFP_CPP_ACTION_RW;
> -		fallthrough;
> +		break;
>  	case NFP_PCIE_BAR_PCIE2CPP_MapType_FIXED:
>  		break;
>  	default:

This is a cascading fall-through handling all map types.
I don't think this change improves readability.

...
