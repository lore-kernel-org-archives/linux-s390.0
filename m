From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] virtio/s390: fix race in ccw_io_helper()
Date: Mon, 24 Sep 2018 15:32:57 +0200
Message-ID: <20180924153257.24f367a4.cohuck@redhat.com>
References: <20180921124621.43649-1-pasic@linux.ibm.com>
	<20180921124621.43649-3-pasic@linux.ibm.com>
	<20180921153031.77f7693b.cohuck@redhat.com>
	<a55df275-d982-c051-1b17-465e3a30777f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a55df275-d982-c051-1b17-465e3a30777f@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 24 Sep 2018 14:57:26 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/21/2018 03:30 PM, Cornelia Huck wrote:
> > On Fri, 21 Sep 2018 14:46:21 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> Again, not what I tried to say. By 'This' I meant 'this race'. How
> about?
> 
> """
> This race normally does not cause any problems. The operations provided
> by struct virtio_config_ops are usually invoked in a well defined sequence,
> normally don't fail, and are normally usually quite infrequent too.

s/usually/used/

> 
> Yet, if some of the these operations are directly triggered via
> sysfs attributes, like in the case described by the referenced bug,
> userspace is given an opportunity to force races by increasing the
> frequency of the given operations.
> """

Fine with me.
