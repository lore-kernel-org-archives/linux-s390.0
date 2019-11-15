Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbfKOJV5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 04:21:57 -0500
Subject: Re: [PATCH] Fixup sida bouncing
References: <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
 <20191114162153.25349-1-frankja@linux.ibm.com>
 <016cea87-9097-ca8b-2d19-9f69cdff3af6@redhat.com>
 <87488647-8a49-d555-e3fc-3b218dd022d1@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0e660f27-db7d-0c44-9ecf-dbfeee459c4d@redhat.com>
Date: Fri, 15 Nov 2019 10:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <87488647-8a49-d555-e3fc-3b218dd022d1@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com

On 15/11/2019 09.50, Janosch Frank wrote:
> On 11/15/19 9:19 AM, Thomas Huth wrote:
[...]
>> Still, is there a way you could also verify that gaddr references the
>> right page that is mirrored in the sidad?
>>
>>  Thomas
>>
>=20
> I'm not completely sure if I understand your question correctly.
> Checking that is not possible here without also looking at the
> instruction bytecode and register contents which would make this patch
> ridiculously large with no real benefit.

Yes, I was thinking about something like that. I mean, how can you be
sure that the userspace really only wants to read the contents that are
references by the sidad? It could also try to read or write e.g. the
lowcore data inbetween (assuming that there are some code paths left
which are not aware of protected virtualization yet)?

Well, it does not have to be right now and in this patch, but I still
think that's something that should be added in the future if somehow
possible...

 Thomas
