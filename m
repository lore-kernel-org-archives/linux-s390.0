Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60790 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727686AbfLBTtf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 14:49:35 -0500
Date: Mon, 2 Dec 2019 20:49:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 6/9] s390x: css: stsch, enumeration
 test
Message-ID: <20191202204922.508d389f.cohuck@redhat.com>
In-Reply-To: <bb189d95-ddfc-7031-d0dd-7de3e0dd5a7f@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
        <1574945167-29677-7-git-send-email-pmorel@linux.ibm.com>
        <20191202152246.4d627b0e.cohuck@redhat.com>
        <aa588c00-79ac-2942-7911-b476abb224db@linux.ibm.com>
        <20191202191541.1ffd987e.cohuck@redhat.com>
        <bb189d95-ddfc-7031-d0dd-7de3e0dd5a7f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 2 Dec 2019 19:33:59 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2019-12-02 19:15, Cornelia Huck wrote:
> > On Mon, 2 Dec 2019 18:53:16 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> On 2019-12-02 15:22, Cornelia Huck wrote:  
> >>> On Thu, 28 Nov 2019 13:46:04 +0100
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:  
> >   
> >>>> +static int test_device_sid;
> >>>> +
> >>>> +static void test_enumerate(void)
> >>>> +{
> >>>> +	struct pmcw *pmcw = &schib.pmcw;
> >>>> +	int sid;
> >>>> +	int ret, i;
> >>>> +	int found = 0;
> >>>> +
> >>>> +	for (sid = 0; sid < 0xffff; sid++) {
> >>>> +		ret = stsch(sid|SID_ONE, &schib);  
> >>>
> >>> This seems a bit odd. You are basically putting the subchannel number
> >>> into sid, OR in the one, and then use the resulting value as the sid
> >>> (subchannel identifier).
> >>>      
> >>>> +		if (!ret && (pmcw->flags & PMCW_DNV)) {
> >>>> +			report_info("SID %04x Type %s PIM %x", sid,  
> >>>
> >>> That's not a sid, but the subchannel number (see above).
> >>>      
> >>>> +				     Channel_type[pmcw->st], pmcw->pim);
> >>>> +			for (i = 0; i < 8; i++)  {
> >>>> +				if ((pmcw->pim << i) & 0x80) {
> >>>> +					report_info("CHPID[%d]: %02x", i,
> >>>> +						    pmcw->chpid[i]);
> >>>> +					break;
> >>>> +				}
> >>>> +			}
> >>>> +			found++;
> >>>> +	
> >>>> +		}  
> >>>
> >>> Here, you iterate over the 0-0xffff range, even if you got a condition
> >>> code 3 (indicating no more subchannels in that set). Is that
> >>> intentional?  
> >>
> >> I thought there could be more subchannels.
> >> I need then a break in the loop when this happens.
> >> I will reread the PoP to see how to find that no more subchannel are in
> >> that set.  
> > 
> > The fact that cc 3 for stsch == no more subchannels is unfortunately a
> > bit scattered across the PoP :/ Dug it out some time ago, maybe it's
> > still in the archives somewhere...  
> 
> So the the subchannel are always one after the other?

While QEMU (and z/VM) usually do that, they can really be scattered
around. For the in-between I/O subchannels that don't lead to a device,
you'll still get cc 0, it's just the dnv bit that is 0. The cc 3
basically just tells you that you can stop looking.
