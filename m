Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [RFC PATCH net 0/3] net/smc: move some definitions to UAPI
References: <cover.1538929504.git.esyr@redhat.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 9 Oct 2018 17:43:03 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1538929504.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3ba9cb5c-8ad9-70ab-3d32-2226a6e9f39a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>, Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 10/07/2018 06:34 PM, Eugene Syromiatnikov wrote:
> Hello.
> 
> As of now, it's a bit difficult to use SMC protocol, as significant part
> of definitions related to it are defined in private headers and are not
> part of UAPI. The following commits move some definitions to UAPI,
> making them readily available to user space.
> 
> 
> Eugene Syromiatnikov (3):
>   uapi, net/smc: move protocol constant definitions to UAPI
>   uapi, net/smc: provide fallback diagnosis codes in UAPI
>   uapi, net/smc: provide socket state constants in UAPI
> 
>  include/uapi/linux/smc.h      | 26 +++++++++++++++++++++++++-
>  include/uapi/linux/smc_diag.h | 17 +++++++++++++++++
>  net/smc/smc.h                 | 22 ++--------------------
>  net/smc/smc_clc.h             | 16 ----------------
>  4 files changed, 44 insertions(+), 37 deletions(-)
> 

Hello Eugene,

I am OK with your 3 patches.

Thanks, Ursula
