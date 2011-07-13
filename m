Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <20110713184611.6dcb09b4@mschwide>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	 <20110705202615.GJ24348@redhat.com>	<1309944287.3937.39.camel@br98xy6r>
	 <20110707193321.GE28850@redhat.com>	<20110708110121.5acfc3c9@mschwide>
	 <20110711144255.GE30674@redhat.com>	<20110711175626.121dcc58@mschwide>
	 <20110713160239.GE4426@redhat.com>  <20110713184611.6dcb09b4@mschwide>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Jul 2011 18:59:50 +0200
Message-ID: <1310576390.2864.9.camel@br98xy6r>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, ebiederm@xmission.com, hbabu@us.ibm.com, mahesh@linux.vnet.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2011-07-13 at 18:46 +0200, Martin Schwidefsky wrote:
> On Wed, 13 Jul 2011 12:02:39 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> > So in case of stand alone dump, you save the calculated checksum of
> > kdump kernel at disk and not in memory? And then calculate the checksum
> > of memory image of kdump kernel and decide whether kdump kenrel is 
> > corrupted or not?
> > 
> > If yes, this sounds more reliable as checksum of kernel is stored on
> > some disk/tape.
> 
> No, the checksum for the purgatory code is stored in memory. If the purgatory
> code is corrupted you would have to corrupt the checksum in a very specific
> way as well to make it fail. 

Currently we store the checksums for the loaded *kexec segments* in
memory at the end of kexec_load(). The stand-alone dump tools also
calculate the checksums for all segments and compare them with the
stored checksums. The dump tools can do that because we have meminfos
for all segments. A meminfo element contains:
* address of memory chunk
* size of memory chunk
* checksum of memory chunk (calculated at the end of kexec_load()

Michael
