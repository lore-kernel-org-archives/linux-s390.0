From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/3] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 27 Aug 2014 14:58:55 -0400
Message-ID: <20140827185855.GB6568@laptop.dumpdata.com>
References: <cover.1409087794.git.luto@amacapital.net>
	<CAJSP0QUcXQ+JV0wys2Mr-+OsFKt=hTGbUxNqfpk-JuyULiQABQ@mail.gmail.com>
	<20140827172716.GA5379@laptop.dumpdata.com>
	<CAJSP0QVS-qCsKNDetoV4nEUvpv-14aDJzinYoM1t2pd4_5Q5Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJSP0QVS-qCsKNDetoV4nEUvpv-14aDJzinYoM1t2pd4_5Q5Hg@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 27, 2014 at 07:10:20PM +0100, Stefan Hajnoczi wrote:
> On Wed, Aug 27, 2014 at 6:27 PM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> > On Wed, Aug 27, 2014 at 07:46:46AM +0100, Stefan Hajnoczi wrote:
> >> On Tue, Aug 26, 2014 at 10:16 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> > There are two outstanding issues.  virtio_net warns if DMA debugging
> >> > is on because it does DMA from the stack.  (The warning is correct.)
> >> > This also is likely to do something unpleasant to s390.
> >> > (Maintainers are cc'd -- I don't know what to do about it.)
> >>
> >> This changes the semantics of vring and breaks existing guests when
> >> bus address != physical address.
> >
> > Isn't that what this is suppose to fix? Right now the semantics of the
> > vring is that bus address == physical address.
> 
> Today the assumption is that the device emulation code has access to
> guest physical memory (no translation necessary).

Right.
> 
> Changing the semantics breaks today's guests.  You need to make this
> change in a way so that existing guests don't break.

Well, the DMA API will preserve that semantic as under KVM it will
return phys == bus.

But that is a side-effect of the DMA API implementation preserving
this semantic so I understand your point.
> 
> Stefan
