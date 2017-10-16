From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] vfio-ccw bugfix
Date: Mon, 16 Oct 2017 11:37:47 +0200
Message-ID: <20171016113747.1a25ef4d.cohuck@redhat.com>
References: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Oct 2017 04:38:20 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Some bugfixes according to recent discussion.
> 
> Dong Jia Shi (2):
>   vfio: ccw: bypass bad idaw address when fetching IDAL ccws
>   vfio: ccw: validate the count field of a ccw before pinning
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 

Thanks, applied.
