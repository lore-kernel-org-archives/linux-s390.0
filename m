Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406888AbgFYTzC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 15:55:02 -0400
Received: by mail-ed1-f72.google.com with SMTP id c1so5905100edd.21
        for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2020 12:54:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Date: Thu, 25 Jun 2020 21:54:56 +0200
Message-Id: <93B4CEE2-3C8D-481F-89BC-09C931866201@redhat.com>
References: <20200625193837.GA5050@osiris>
In-Reply-To: <20200625193837.GA5050@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>



> Am 25.06.2020 um 21:38 schrieb Heiko Carstens <heiko.carstens@de.ibm.com>:=

>=20
> =EF=BB=BFOn Thu, Jun 25, 2020 at 05:00:29PM +0200, David Hildenbrand wrote=
:
>> This smells like a leftover from ancient times, let's get rid of it. We
>> can now convert vmem_remove_mapping() into a void function - everybody
>> ignored the return value already.
>=20
> This buys us what? Except that we get rid of a bit of code?

I=E2=80=98m looking into virtio-mem support for s390x, including vmemmap/vme=
m optimizations. Virtio-mem adds/removes memory in memory block granularity,=
 which results in one list entry for essentially each memory section. That s=
eems to be easy to avoid.

Thanks=
