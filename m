From: "Evgeny Cherkashin" <Eugene.Crosser@ru.ibm.com>
Date: Fri, 18 Mar 2016 13:07:34 +0000
Subject: Re: [PATCH] qeth: Default to allow promiscuous mode
Message-Id: <201603181307.u2ID7k0o008252@d06av05.portsmouth.uk.ibm.com>
In-Reply-To: <201603181207.u2IC7ns9030434@d06av10.portsmouth.uk.ibm.com>
References: <201603181207.u2IC7ns9030434@d06av10.portsmouth.uk.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Alexander,

-----Alexander Graf <agraf@suse.de> wrote: -----

send it explicitly if that makes it move obvious, sure.
>
>> 3. The patch should probably go via the -networking maillist.
>
>Ah, get_maintainers.pl didn't list it. You may want to send a patch
>for
>the MAINTAINERS file here :).

My mistake, you've sent it to the right place.

About the nature of the patch:

- Enabling bridgeport on adaptors on which bridgeport is already used by somebody else will break somebody else's operation.

- Therefore, system administrator must only enable bridgeport on adaptors on which nobody else tries to use it (without coordinating with them).

- Making bridge_reflect_promisc enabled by default makes it impossible.

- Therefore, bridge_reflect_promisc must not be enabled by default.

(Those who enable bridge_reflect_promisc blindly on all adaptors will break their users' setup, and will have to deal with the consequences.)

Regards,

Evgeny Cherkashin / �������������� ���������������� / Eugene Crosser (preferred)
Software Engineer, IBM Science and Technology Center, Linux on z-Systems Development
tel. +7 495 775 8800 ext.1103, Moscow 123317, Presnenskaya emb. 10
