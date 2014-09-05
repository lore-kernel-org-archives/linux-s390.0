From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Thu, 4 Sep 2014 20:06:57 -0700
Message-ID: <CALCETrVcg27-RR7DR635u0fU6XKijZKOoLhFN-hr47a3TS57qg@mail.gmail.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<874mwpkxxi.fsf@rustcorp.com.au> <20140903125111.GA14901@redhat.com>
	<87k35ikd9u.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k35ikd9u.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 4, 2014 at 7:32 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> On Wed, Sep 03, 2014 at 04:12:01PM +0930, Rusty Russell wrote:
>>> Andy Lutomirski <luto@amacapital.net> writes:
>>> > There really are virtio devices that are pieces of silicon and not
>>> > figments of a hypervisor's imagination [1].
>>>
>>> Hi Andy,
>>>
>>>         As you're discovering, there's a reason no one has done the DMA
>>> API before.
>>>
>>> So the problem is that ppc64's IOMMU is a platform thing, not a bus
>>> thing.  They really do carve out an exception for virtio devices,
>>> because performance (LOTS of performance).  It remains to be seen if
>>> other platforms have the same performance issues, but in absence of
>>> other evidence, the answer is yes.
>>>
>>> It's a hack.  But having specific virtual-only devices are an even
>>> bigger hack.
>>>
>>> Physical virtio devices have been talked about, but don't actually exist
>>> in Real Life.  And someone a virtio PCI card is going to have serious
>>> performance issues: mainly because they'll want the rings in the card's
>>> MMIO region, not allocated by the driver.
>>
>> Why? What's wrong with rings in memory?
>
> AFAICT, the card would have to access guest memory to read it, using
> multiple DMA cycles.  That's going to be slow.

I don't personally know all the considerations, but AFAICT NVMe puts
its rings in memory, and NMVe is very much focused on performance.

There might be an argument for trying to avoid using indirect rings on
real hardware to reduce the number of DMA round-trips needed for a
comment.

--Andy
