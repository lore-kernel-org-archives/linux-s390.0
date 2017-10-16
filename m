From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PULL 0/2] vfio-ccw fixes
Date: Mon, 16 Oct 2017 12:46:29 +0200
Message-ID: <20171016124629.20de7c0f@mschwideX1>
References: <20171016095036.27637-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171016095036.27637-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Oct 2017 11:50:34 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit fe3af62553896d2a6b13c931137406681d76c3e4:
> 
>   s390: update defconfig (2017-10-16 08:19:28 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20171016
> 
> for you to fetch changes up to 4cebc5d6a6ff41c0266d235aa4854b062d34ad09:
> 
>   vfio: ccw: validate the count field of a ccw before pinning (2017-10-16 11:14:48 +0200)
> 
> ----------------------------------------------------------------
> Some improvements in data handling for vfio-ccw.
> 
> ----------------------------------------------------------------
> 
> Dong Jia Shi (2):
>   vfio: ccw: bypass bad idaw address when fetching IDAL ccws
>   vfio: ccw: validate the count field of a ccw before pinning
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 

The vfio update is merged and pushed to s390/linux:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
