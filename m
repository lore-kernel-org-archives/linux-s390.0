From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] virtio/s390: avoid race on vcdev->config
Date: Mon, 24 Sep 2018 16:50:30 +0200
Message-ID: <20180924165030.2df3248a.cohuck@redhat.com>
References: <20180921124621.43649-1-pasic@linux.ibm.com>
	<20180921124621.43649-2-pasic@linux.ibm.com>
	<20180921151433.519b6687.cohuck@redhat.com>
	<d05aa6cb-d344-37dd-f1eb-55c28fcb9c62@linux.ibm.com>
	<80a80dc6-ccb1-f245-b367-c2f9345ca151@linux.ibm.com>
	<20180924145554.712f4cf4.cohuck@redhat.com>
	<2b8982be-9066-cf08-657b-99ecf889e4a7@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2b8982be-9066-cf08-657b-99ecf889e4a7@linux.ibm.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, virtualization@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 24 Sep 2018 16:27:30 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/24/2018 02:55 PM, Cornelia Huck wrote:
> > On Fri, 21 Sep 2018 17:47:47 -0400
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >   
> >> On 09/21/2018 09:28 AM, Halil Pasic wrote:  
> >   
> >>> Anyway I'm fine with swapping the old out and your new version in,
> >>> if you prefer it that way.
> >>>
> >>> If you do, would you like to have a respin?  
> > 
> > Just send me a respin with something that you find useful :) (maybe a
> > mashup of our descriptions) (while at it, you could also add the
> > cc:stable, which I agree make sense)
> >   
> 
> Will do! I would like to go with.
> 
> 
> """
> This normally does not cause problems, as these are usually infrequent
> operations. However, for some devices writing to/reading from the config space
> can be triggered through sysfs attributes. For these userspace can force the
> race by increasing the frequency.
> """

Sounds good.
