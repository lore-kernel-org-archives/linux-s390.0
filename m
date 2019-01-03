From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 0/1] virtio-ccw: one more patch for 4.21
Date: Thu, 3 Jan 2019 11:50:22 -0500
Message-ID: <20190103114955-mutt-send-email-mst@kernel.org>
References: <20181219101414.13901-1-cohuck@redhat.com>
	<20190103095507.7ef65472.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190103095507.7ef65472.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 03, 2019 at 09:55:07AM +0100, Cornelia Huck wrote:
> On Wed, 19 Dec 2018 11:14:13 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > The following changes since commit 37d1246af2d530710cf5822d2845774f01c03b22:
> > 
> >   virtio_net: bulk free tx skbs (2018-12-06 14:28:39 -0500)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-ccw-20181219
> > 
> > for you to fetch changes up to 6fb95ef30707f1b2fcaea8d6dc873055e0460b1a:
> > 
> >   virtio-ccw: diag 500 may return a negative cookie (2018-12-19 11:01:57 +0100)
> > 
> > ----------------------------------------------------------------
> > One small documentation fix for 4.21.
> > 
> > ----------------------------------------------------------------
> > 
> > Cornelia Huck (1):
> >   virtio-ccw: diag 500 may return a negative cookie
> > 
> >  Documentation/virtual/kvm/s390-diag.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> ping?

Sorry holidays :)

I'll pick this up for the next pull.

-- 
MST
