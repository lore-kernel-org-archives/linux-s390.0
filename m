From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 0/9] zfcp features and bugfixes for 3.10 merge
 window
Date: Fri, 26 Apr 2013 17:44:41 +0200
Message-ID: <517AA0E9.6060008@linux.vnet.ibm.com>
References: <1366985635-38270-1-git-send-email-maier@linux.vnet.ibm.com> <1366989019.1927.2.camel@dabdike>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1366989019.1927.2.camel@dabdike>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 04/26/2013 05:10 PM, James Bottomley wrote:
> On Fri, 2013-04-26 at 16:13 +0200, Steffen Maier wrote:
>> James,
>>
>> here is a series of zfcp features and bugfixes.
>> We would very much appreciate if you could integrate them for the
>> upcoming merge window preparing kernel v3.10.
>> The patches apply on top of the current misc branch of your scsi.git=
=2E
>>
>> Apparently, I did something wrong on git-send-email so the mails
>> did not appear on the mailing lists. Apologies for resending.
>
> Since no-one saw the originals, apologies aren't necessary.
> Unfortunately, you're still missing three patches: 5,6,9/9

Hm, just the patches that had something like this in the signature area=
:
Cc: <stable@vger.kernel.org> #2.6.37+
I guess they got stuck because some MTA or the list do not like what=20
git-send-email converted this into as a CC recipient:
<stable@vger.kernel.org> #2.6.37+

I resent those three as replies to the stuck/lost ones.

Steffen

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

--
To unsubscribe from this list: send the line "unsubscribe linux-scsi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
