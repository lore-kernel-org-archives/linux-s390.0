Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgFQLZx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 07:25:53 -0400
Subject: Re: [kvm-unit-tests PATCH v9 11/12] s390x: css: msch, enable test
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-12-git-send-email-pmorel@linux.ibm.com>
 <20200617105433.6a79e92c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <c529e53c-3b4e-8c5f-9dc2-4a7a1507a44e@linux.ibm.com>
Date: Wed, 17 Jun 2020 13:25:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200617105433.6a79e92c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-06-17 10:54, Cornelia Huck wrote:
> On Mon, 15 Jun 2020 11:32:00 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> A second step when testing the channel subsystem is to prepare a channel
>> for use.
...snip...
>> +
>> +	/* Read the SCHIB for this subchannel */
>> +	cc = stsch(schid, &schib);
>> +	if (cc) {
>> +		report_info("stsch failed with cc=%d", cc);
> 
> Mention the schid in the message?

Yes:
report_info("stsch: sch %08x failed with cc=%d", schid, cc);

> 
>> +		return cc;
>> +	}
>> +
>> +	if (pmcw->flags & PMCW_ENABLE) {
>> +		report_info("stsch: sch %08x already enabled", schid);
>> +		return 0;
>> +	}
>> +
>> +retry:
>> +	/* Update the SCHIB to enable the channel */
>> +	pmcw->flags |= PMCW_ENABLE;
>> +
>> +	/* Tell the CSS we want to modify the subchannel */
>> +	cc = msch(schid, &schib);
>> +	if (cc) {
>> +		/*
>> +		 * If the subchannel is status pending or
>> +		 * if a function is in progress,
>> +		 * we consider both cases as errors.
>> +		 */
>> +		report_info("msch failed with cc=%d", cc);

added schid here too

>> +		return cc;
>> +	}
>> +
>> +	/*
>> +	 * Read the SCHIB again to verify the enablement
>> +	 */
>> +	cc = stsch(schid, &schib);
>> +	if (cc) {
>> +		report_info("stsch failed with cc=%d", cc);
> 
> Also add the schid here? Maybe also add a marker to distinguish the two
> cases?

changed to:
report_info("stsch: updating sch %08x failed with cc=%d",schid, cc);
                     ^^^
> 
>> +		return cc;
>> +	}
>> +
>> +	if (pmcw->flags & PMCW_ENABLE) {
>> +		report_info("Subchannel %08x enabled after %d retries",
>> +			    schid, retry_count);
>> +		return 0;
>> +	}
>> +
>> +	if (retry_count++ < MAX_ENABLE_RETRIES) {
>> +		mdelay(10); /* the hardware was not ready, give it some time */
>> +		goto retry;
>> +	}
>> +
>> +	report_info("msch: enabling sch %08x failed after %d retries. pmcw flags: %x",
>> +		    schid, retry_count, pmcw->flags);
>> +	return -1;
>> +}
> 
> With the messages updated,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
