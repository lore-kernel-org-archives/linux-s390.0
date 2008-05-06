From: Avi Kivity <avi@qumranet.com>
Subject: Re: s390 kvm_virtio.c build error
Date: Tue, 06 May 2008 17:39:03 +0300
Message-ID: <48206D87.7080609@qumranet.com>
References: <20080503174716.GM5838@cs181133002.pp.htv.fi>	
	<20080504192537.GA5499@osiris.boeblingen.de.ibm.com>	
	<200805051429.47446.borntraeger@de.ibm.com>
	<481F0504.3010503@qumranet.com>
	<1209992810.7089.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1209992810.7089.15.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Carsten Otte <cotte@de.ibm.com>, Adrian Bunk <bunk@kernel.org>, linux-s390@vger.kernel.org, kvm-devel@lists.sourceforge.net, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
> I've added Heiko's patch to my patchqueue. But since this is
> drivers/s390/kvm this should go in over the kvm.git. See patch below.
>
>   

Thanks, I added this to my queue as well.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
