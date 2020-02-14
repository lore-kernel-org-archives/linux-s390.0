Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728123AbgBNO14 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 09:27:56 -0500
Subject: Re: [RFC PATCH v2 9/9] vfio-ccw: Remove inline get_schid() routine
References: <20200206213825.11444-1-farman@linux.ibm.com>
 <20200206213825.11444-10-farman@linux.ibm.com>
 <20200214142706.4d6a1efc.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <202b7945-0701-cbd2-6da3-279b63a02199@linux.ibm.com>
Date: Fri, 14 Feb 2020 09:27:52 -0500
MIME-Version: 1.0
In-Reply-To: <20200214142706.4d6a1efc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 2/14/20 8:27 AM, Cornelia Huck wrote:
> On Thu,  6 Feb 2020 22:38:25 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> This seems misplaced in the middle of FSM, returning the schid
>> field from inside the private struct.  We could move this macro
>> into vfio_ccw_private.h, but this doesn't seem to simplify things
>> that much.  Let's just remove it, and use the field directly.
> 
> It had been introduced with the first set of traces, I'm now wondering
> why, as it doesn't do any checking.

Hrm, that's a decent question.  I could refactor this, moving the
routine into vfio_ccw_private.h and add those checks, rather than
removing it outright.

I honestly only stumbled on this when I tried to use get_schid()
somewhere else, not realizing the definition was actually tucked away in
here.  And so I've left it on the end of this series as a matter of
convenience/non-forgetfulness, but splitting it out by itself would be fine.

> 
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>  drivers/s390/cio/vfio_ccw_fsm.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
