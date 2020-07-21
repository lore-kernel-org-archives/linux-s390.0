Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728700AbgGUO23 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jul 2020 10:28:29 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-3-frankja@linux.ibm.com>
 <78da93f7-118d-2c1d-582a-092232f36108@redhat.com>
 <032c1103-3020-9deb-a307-70ded3bdb55e@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1aa0a21c-90c9-0214-1869-87cc60a46548@redhat.com>
Date: Tue, 21 Jul 2020 16:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <032c1103-3020-9deb-a307-70ded3bdb55e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 21/07/2020 10.52, Janosch Frank wrote:
> On 7/21/20 9:28 AM, Thomas Huth wrote:
>> On 17/07/2020 16.58, Janosch Frank wrote:
>>> If a exception new psw mask contains a key a specification exception
>>> instead of a special operation exception is presented.
>>
>> I have troubles parsing that sentence... could you write that differently?
>> (and: "s/a exception/an exception/")
> 
> How about:
> 
> When an exception psw new with a storage key in its mask is loaded from
> lowcore a specification exception is raised instead of the special
> operation exception that is normally presented when skrf is active.

Still a huge beast of a sentence. Could you maybe make two sentences out
of it? For example:

" ... is raised. This differs from the normal case where ..."

?

 Thomas
