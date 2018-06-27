From: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Subject: [PATCH] test_bpf: flag tests that cannot be jited on s390
Date: Wed, 27 Jun 2018 17:19:21 +0200
Message-ID: <20180627151921.15018-1-kleber.souza@canonical.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
List-ID: <linux-s390.vger.kernel.org>

Flag with FLAG_EXPECTED_FAIL the BPF_MAXINSNS tests that cannot be jited
on s390 because they exceed BPF_SIZE_MAX and fail when
CONFIG_BPF_JIT_ALWAYS_ON is set. Also set .expected_errcode to -ENOTSUPP
so the tests pass in that case.

Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
---
 lib/test_bpf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 60aedc879361..08d3d59dca17 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5282,21 +5282,31 @@ static struct bpf_test tests[] = {
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Ctx heavy transformations",
 		{ },
+#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
+		CLASSIC | FLAG_EXPECTED_FAIL,
+#else
 		CLASSIC,
+#endif
 		{ },
 		{
 			{  1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
 			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
 		},
 		.fill_helper = bpf_fill_maxinsns6,
+		.expected_errcode = -ENOTSUPP,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Call heavy transformations",
 		{ },
+#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
+		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
+#else
 		CLASSIC | FLAG_NO_DATA,
+#endif
 		{ },
 		{ { 1, 0 }, { 10, 0 } },
 		.fill_helper = bpf_fill_maxinsns7,
+		.expected_errcode = -ENOTSUPP,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Jump heavy test",
@@ -5347,18 +5357,28 @@ static struct bpf_test tests[] = {
 	{
 		"BPF_MAXINSNS: exec all MSH",
 		{ },
+#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
+		CLASSIC | FLAG_EXPECTED_FAIL,
+#else
 		CLASSIC,
+#endif
 		{ 0xfa, 0xfb, 0xfc, 0xfd, },
 		{ { 4, 0xababab83 } },
 		.fill_helper = bpf_fill_maxinsns13,
+		.expected_errcode = -ENOTSUPP,
 	},
 	{
 		"BPF_MAXINSNS: ld_abs+get_processor_id",
 		{ },
+#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
+		CLASSIC | FLAG_EXPECTED_FAIL,
+#else
 		CLASSIC,
+#endif
 		{ },
 		{ { 1, 0xbee } },
 		.fill_helper = bpf_fill_ld_abs_get_processor_id,
+		.expected_errcode = -ENOTSUPP,
 	},
 	/*
 	 * LD_IND / LD_ABS on fragmented SKBs
-- 
2.17.1
