Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732776AbgGaMJs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 08:09:48 -0400
Subject: Re: [kvm-unit-tests GIT PULL 00/11] s390x patches
References: <20200731094607.15204-1-frankja@linux.ibm.com>
 <dfce14f4-5e7b-9060-6520-06e7dd69cfa4@redhat.com>
 <524d5b00-94ec-da47-601a-a5909e3ed63e@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <00cc99d2-6020-3111-38a4-232991ffcf0d@redhat.com>
Date: Fri, 31 Jul 2020 14:09:32 +0200
MIME-Version: 1.0
In-Reply-To: <524d5b00-94ec-da47-601a-a5909e3ed63e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

On 31/07/2020 13.31, Janosch Frank wrote:
> On 7/31/20 12:31 PM, Paolo Bonzini wrote:
>> On 31/07/20 11:45, Janosch Frank wrote:
>>>   https://github.com/frankjaa/kvm-unit-tests.git tags/s390x-2020-31-07
>>
>> Pulled, thanks.  FWIW you may want to gitlab in order to get the CI.
>>
>> Paolo
>>
> 
> Hey Paolo, that repository is hooked up to travis already:
> https://travis-ci.com/github/frankjaa/kvm-unit-tests/builds/177931162
> 
> I'll consider it if it has any benefit.
> @Thomas: Are there differences in the CI?

Not that much, you get a good build test coverage with both. Travis uses
real (nested) KVM tests, but the compiler and QEMU versions are a little
bit backlevel (still using Ubuntu bionic). Gitlab-CI uses newer versions
(thanks to Fedora 32), but there is no KVM support here, so the tests
run with TCG only (I'm thinking of adding the cirrus-run script to the
Gitlab-CI, maybe we could get some KVM-coverage that way there, too, but
that will certainly take some time to figure it out).

 Thomas
