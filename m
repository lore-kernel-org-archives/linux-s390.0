Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28816 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgJEQQR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Oct 2020 12:16:17 -0400
Subject: Re: [PATCH v2 3/5] vfio-pci/zdev: define the vfio_zdev header
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
 <1601668844-5798-4-git-send-email-mjrosato@linux.ibm.com>
 <20201002154417.20c2a7ef@x1.home>
 <8a71af3b-f8fc-48b2-45c6-51222fd2455b@linux.ibm.com>
 <20201005180107.5d027441.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <e0688173-8c5a-1797-8398-235c5e406bc1@linux.ibm.com>
Date: Mon, 5 Oct 2020 12:16:10 -0400
MIME-Version: 1.0
In-Reply-To: <20201005180107.5d027441.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/5/20 12:01 PM, Cornelia Huck wrote:
> On Mon, 5 Oct 2020 09:52:25 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 10/2/20 5:44 PM, Alex Williamson wrote:
> 
>>> Can you discuss why a region with embedded capability chain is a better
>>> solution than extending the VFIO_DEVICE_GET_INFO ioctl to support a
>>> capability chain and providing this info there?  This all appears to be
>>> read-only info, so what's the benefit of duplicating yet another
>>
>> It is indeed read-only info, and the device region was defined as such.
>>
>> I would not necessarily be opposed to extending VFIO_DEVICE_GET_INFO
>> with these defined as capabilities; I'd say a primary motivating factor
>> to putting these in their own region was to avoid stuffing a bunch of
>> s390-specific capabilities into a general-purpose ioctl response.
> 
> Can't you make the zdev code register the capabilities? That would put
> them nicely into their own configurable part.
> 

I can still keep the code that adds these capabilities in the zdev .c 
file, thus meaning they will only be added for s390 zpci devices -- but 
the actual definition of them should probably instead be in vfio.h, no? 
(maybe that's what you mean, but let's lay it out just in case)

The capability IDs would be shared with any other potential user of 
VFIO_DEVICE_GET_INFO (I guess there is precedent for this already, 
nvlink2 does this for vfio_region_info, see 
VFIO_REGION_INFO_CAP_NVLINK2_SSATGT as an example).

Today, ZPCI would be the only users of VFIO_DEVICE_GET_INFO capability 
chains.  Tomorrow, some other type might use them too.  Unless we want 
to put a stake in the ground that says there will never be a case for a 
capability that all devices share on VFIO_DEVICE_GET_INFO, I think we 
should keep the IDs unique and define the capabilities in vfio.h but do 
the corresponding add_capability() calls from a zdev-specific file.

>>
>> But if you're OK with that notion, I can give that a crack in v3.
>>
>>> capability chain in a region?  It would also be possible to define four
>>> separate device specific regions, one for each of these capabilities
>>> rather than creating this chain.  It just seems like a strange approach
>>
>> I'm not sure if creating separate regions would be the right approach
>> though; these are just the first 4.  There will definitely be additional
>> capabilities in support of new zPCI features moving forward, I'm not
>> sure how many regions we really want to end up with.  Some might be as
>> small as a single field, which seems more in-line with capabilities vs
>> an entire region.
> 
> If we are expecting more of these in the future, going with GET_INFO
> capabilities when adding new ones seems like the best approach.
> 
