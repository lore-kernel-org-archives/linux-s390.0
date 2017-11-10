From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PULL 0/1] vfio-ccw: bugfix
Date: Fri, 10 Nov 2017 19:15:29 +0100
Message-ID: <20171110181529.GA3028@osiris>
References: <20171109162120.27453-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109162120.27453-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: schwidefsky@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 09, 2017 at 05:21:19PM +0100, Cornelia Huck wrote:
> The following changes since commit 978fa72e82e375764e6e31e7a721408c5186918f:
> 
>   s390: remove named saved segment support (2017-11-08 09:47:54 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20171109
> 
> for you to fetch changes up to 408358b50deaf59b07c82a7bff8c7e7cce031fae:
> 
>   s390: vfio-ccw: Do not attempt to free no-op, test and tic cda. (2017-11-08 14:39:53 +0100)
> 
> ----------------------------------------------------------------
> A vfio-ccw bugfix: avoid freeing that which should not be freed.
> 
> ----------------------------------------------------------------
> 
> Jason J. Herne (1):
>   s390: vfio-ccw: Do not attempt to free no-op, test and tic cda.

Pulled into features branch. Thanks!
