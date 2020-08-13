Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgHMLh6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 07:37:58 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC v2 1/4] common.bash: run `cmd` only if a test case was found
In-Reply-To: <20200813074059.y4qvrne5thm2olf2@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com> <20200812092705.17774-2-mhartmay@linux.ibm.com> <20200813074059.y4qvrne5thm2olf2@kamzik.brq.redhat.com>
Date: Thu, 13 Aug 2020 13:37:50 +0200
Message-ID: <87o8nehj3l.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, Aug 13, 2020 at 09:40 AM +0200, Andrew Jones <drjones@redhat.com> w=
rote:
> On Wed, Aug 12, 2020 at 11:27:02AM +0200, Marc Hartmayer wrote:
>> It's only useful to run `cmd` in `for_each_unittest` if a test case
>> was found. This change allows us to remove the guards from the
>> functions `run_task` and `mkstandalone`.
>>=20
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  run_tests.sh            | 3 ---
>>  scripts/common.bash     | 8 ++++++--
>>  scripts/mkstandalone.sh | 4 ----
>>  3 files changed, 6 insertions(+), 9 deletions(-)
>>
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>

Thanks.

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
